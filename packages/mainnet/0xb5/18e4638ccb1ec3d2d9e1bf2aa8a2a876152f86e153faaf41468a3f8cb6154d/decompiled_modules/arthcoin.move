module 0xb518e4638ccb1ec3d2d9e1bf2aa8a2a876152f86e153faaf41468a3f8cb6154d::arthcoin {
    struct ARTHCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTHCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTHCOIN>(arg0, 6, b"ARTHCOIN", b"Yer King Arthur's Olde Coin", b"These coins belonged to the mythical King Arthur. It is said was lost during his heroic duel against Sir Lancelot...it has been recently found and now it can be yours!!...brings fortune to those who hold one of these.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_1919055da8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTHCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTHCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

