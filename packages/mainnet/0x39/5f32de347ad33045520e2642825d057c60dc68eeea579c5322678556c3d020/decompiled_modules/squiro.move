module 0x395f32de347ad33045520e2642825d057c60dc68eeea579c5322678556c3d020::squiro {
    struct SQUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRO>(arg0, 6, b"SQUIRO", b"Sui Squiro", b"Squiro - Revolutionizing crypto with humor and audacity on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000025827_34b317ce0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

