module 0x85a18d8cfc8794dc104c59913b0ae31155fc24bd6e3ef1bcdb5741b9b00e388e::turtsui {
    struct TURTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTSUI>(arg0, 6, b"Turtsui", b"TURTSUI ", b"TURTSUI is here to take over the Sui chain! With its unique style and contagious humor, it aims to become the iconic meme of the community, bringing light-hearted fun to every block. Ready to unite Sui users with its energy and a dash of craziness, T", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969784901.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURTSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

