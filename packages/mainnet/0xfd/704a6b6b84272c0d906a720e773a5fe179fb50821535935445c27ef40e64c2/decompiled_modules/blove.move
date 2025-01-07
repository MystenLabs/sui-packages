module 0xfd704a6b6b84272c0d906a720e773a5fe179fb50821535935445c27ef40e64c2::blove {
    struct BLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOVE>(arg0, 6, b"Blove", b"Blove is BFIC Future", b"Blove coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blovedapp.com/assets/images/logo-bg-opacity.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

