module 0x99c95bee9f8572db65974a6f5cb1ed934093243d0df3c03fba6e07248cf25b5a::blorbo {
    struct BLORBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORBO>(arg0, 6, b"BLORBO", b"Sui Blorbo", b"Blorbo is a frog with wide eyes and a loveable grin. With a golden crown perched on his head, he reigns supreme over the Base blockchain in his own charming way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250502_021822_db607808a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLORBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

