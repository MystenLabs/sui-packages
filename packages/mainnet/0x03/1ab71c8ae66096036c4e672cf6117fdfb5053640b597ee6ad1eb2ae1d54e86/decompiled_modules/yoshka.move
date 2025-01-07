module 0x31ab71c8ae66096036c4e672cf6117fdfb5053640b597ee6ad1eb2ae1d54e86::yoshka {
    struct YOSHKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOSHKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOSHKA>(arg0, 6, b"YOSHKA", b"Yoshka On Sui", b"The first dog at Google was a friendly Leonberger named Yoshka, also know as the Google 'Top Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_16_58_38_fe7c75b886.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOSHKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOSHKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

