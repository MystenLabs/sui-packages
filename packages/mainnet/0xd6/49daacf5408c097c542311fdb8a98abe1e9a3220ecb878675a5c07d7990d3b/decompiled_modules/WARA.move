module 0xd649daacf5408c097c542311fdb8a98abe1e9a3220ecb878675a5c07d7990d3b::WARA {
    struct WARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARA>(arg0, 6, b"Wara Chief", b"WARA", b"Let bring him back!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/dfcf7431-7ccf-47e5-8ae1-8f96145a0f1b")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARA>>(v0, @0x69695ce612638e168803b6fc962419057df66ab90821e3905d8c60f958ea3682);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

