module 0x783292c8606c01f26fa32b59592169483ecf9172bd604e4af484926e0c9a4ac1::turtsui {
    struct TURTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTSUI>(arg0, 6, b"Turtsui", b"TURTSUI", b"TURTSUI is here to take over the Sui chain! With its unique style and contagious humor, it aims to become the iconic meme of the community, bringing light-hearted fun to every block. Ready to unite Sui users with its energy and a dash of craziness, Turtsui promises to be the undisputed symbol of the chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056557_bf773f5b91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

