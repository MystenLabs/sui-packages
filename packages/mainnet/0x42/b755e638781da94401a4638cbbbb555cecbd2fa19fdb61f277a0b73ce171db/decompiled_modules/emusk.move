module 0x42b755e638781da94401a4638cbbbb555cecbd2fa19fdb61f277a0b73ce171db::emusk {
    struct EMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMUSK>(arg0, 6, b"EMUSK", b"ElonMusk", b"ElonMusk is a meme coin on the Sui network, inspired by Elon Musks creativity and humor. It brings together tech enthusiasts and crypto fans in a vibrant community, combining innovation and fun for a unique digital experience. Join us and blast off", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1705067977_dallc2b7e_2024_01_12_16_57_40_a_dynamic_scene_depicting_a_group_of_5_6_meme_coin_mascots_each_ready_to_fight_representing_various_cryptocurrencies_the_group_includes_the_dogecoi_min_ae6ed5b666.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

