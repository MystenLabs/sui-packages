module 0xfc5b8417b399c8255dbbdeb138ecce0fa6bb8b251519d02111dc32394f375f26::tum {
    struct TUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUM>(arg0, 6, b"TUM", b"tum that fast", b"Tum on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gcs/files/cd28aa87caf2af70b53c1767538edab7.png?auto=format&dpr=1&w=1000")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

