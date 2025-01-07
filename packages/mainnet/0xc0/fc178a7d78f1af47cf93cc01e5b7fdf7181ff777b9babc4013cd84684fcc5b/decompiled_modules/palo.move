module 0xc0fc178a7d78f1af47cf93cc01e5b7fdf7181ff777b9babc4013cd84684fcc5b::palo {
    struct PALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALO>(arg0, 6, b"PALO", b"Palo is the new coin", b"Palo on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hotpot.ai/images/site/ai/photoshoot/avatar/style_gallery/38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PALO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

