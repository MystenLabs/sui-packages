module 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::public_kiosk {
    struct PUBLIC_KIOSK has drop {
        dummy_field: bool,
    }

    struct PairKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Pair has copy, drop, store {
        nft: 0x1::type_name::TypeName,
        token: 0x1::type_name::TypeName,
    }

    struct PublicKiosk has store {
        kiosk: 0x2::kiosk::Kiosk,
        ownerCap: 0x2::kiosk::KioskOwnerCap,
    }

    public(friend) fun delist<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        0x2::kiosk::delist<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1);
    }

    public(friend) fun list<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        0x2::kiosk::list<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1, 0);
    }

    public(friend) fun place<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: T0, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        0x2::kiosk::place<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1);
    }

    public(friend) fun purchase<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        0x2::tx_context::sender(arg3);
        0x2::kiosk::purchase<T0>(&mut arg0.kiosk, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    public(friend) fun take<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: address, arg3: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg3, 1);
        validatePair<T0, T1>(arg0);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1), arg2);
    }

    public(friend) fun createPublicKiosk<T0: store + key, T1>(arg0: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg1: &mut 0x2::tx_context::TxContext) : PublicKiosk {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg0, 1);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = PairKey{dummy_field: false};
        0x2::dynamic_field::add<PairKey, Pair>(0x2::kiosk::uid_mut_as_owner(&mut v3, &v2), v4, getPair<T0, T1>());
        PublicKiosk{
            kiosk    : v3,
            ownerCap : v2,
        }
    }

    public(friend) fun delistAndTake<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: address, arg3: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg3, 1);
        delist<T0, T1>(arg0, arg1, arg3);
        take<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun getPair<T0: store + key, T1>() : Pair {
        Pair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        }
    }

    fun init(arg0: PUBLIC_KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun placeAndList<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: T0, arg2: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version) {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg2, 1);
        place<T0, T1>(arg0, arg1, arg2);
        list<T0, T1>(arg0, 0x2::object::id<T0>(&arg1), arg2);
    }

    fun validatePair<T0: store + key, T1>(arg0: &mut PublicKiosk) {
        let v0 = PairKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<PairKey, Pair>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v0) == getPair<T0, T1>(), 3002);
    }

    // decompiled from Move bytecode v6
}

