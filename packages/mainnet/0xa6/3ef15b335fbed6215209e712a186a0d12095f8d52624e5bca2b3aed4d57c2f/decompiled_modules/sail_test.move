module 0xb481310100f9f9b812de1fb45b8e118f69c6b69e59145bef34b2232efdd7a8e5::sail_test {
    struct SAIL_TEST has drop {
        dummy_field: bool,
    }

    struct MinterCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun burn<T0>(arg0: &mut MinterCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(&mut arg0.cap, arg1);
    }

    public fun mint<T0>(arg0: &mut MinterCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.cap, arg1, arg2)
    }

    public fun total_supply<T0>(arg0: &MinterCap<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.cap)
    }

    public fun destroy<T0>(arg0: MinterCap<T0>) : 0x2::coin::TreasuryCap<T0> {
        let MinterCap {
            id  : v0,
            cap : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun init(arg0: SAIL_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIL_TEST>(arg0, 6, b"SAIL-TEST", b"SAIL-TEST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/sail_test_coin.png"))), arg1);
        let v2 = MinterCap<SAIL_TEST>{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::transfer<MinterCap<SAIL_TEST>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIL_TEST>>(v1);
    }

    public fun unpack_minter_cap<T0>(arg0: MinterCap<T0>) : 0x2::coin::TreasuryCap<T0> {
        let MinterCap {
            id  : v0,
            cap : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

