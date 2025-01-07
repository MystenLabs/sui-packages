module 0x7bb2aeae8170f9f5d264d106363d3e86f32b93c59f99a2db3b20455a89f3ef37::mw {
    struct MW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MW>(arg0, 6, b"MW", b"Maaken Walou", b"Maaken Walou, a famous phrase by an Algerian journalist in a blooper reel, often used to highlight absurdity or humor in situations, especially online.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_6_4a6cfdb403.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MW>>(v1);
    }

    // decompiled from Move bytecode v6
}

