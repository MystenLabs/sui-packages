module 0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::accc {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        coins: 0x2::balance::Balance<T0>,
    }

    public fun coins<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.coins)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::create(arg0);
        0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::init_version(&v0, 1, arg0);
        0x2::transfer::public_transfer<0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::VAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::check(arg1, 1);
        let v0 = Vault<T0>{
            id    : 0x2::object::new(arg2),
            owner : 0x2::tx_context::sender(arg2),
            coins : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::public_share_object<Vault<T0>>(v0);
    }

    public fun migrate(arg0: &mut 0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::Version, arg1: &0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::VAdminCap) {
        0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::migrate(arg0, arg1, 1);
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun transfer_ownership<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::check(arg2, 1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        arg0.owner = arg1;
    }

    public fun unlock<T0>(arg0: Vault<T0>, arg1: &0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::Version, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control::check(arg1, 1);
        let Vault {
            id    : v0,
            owner : v1,
            coins : v2,
        } = arg0;
        assert!(v1 == 0x2::tx_context::sender(arg2), 0);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    // decompiled from Move bytecode v6
}

