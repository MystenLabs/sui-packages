module 0xe6da99019c9f0421c287d688e455315893d192905aef8e3df3d6bac2ab749f90::jcf {
    struct JCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCF>(arg0, 6, b"JCF", b"Joycat - fuck you, higher", b"Joycat, mog, mogged, mogging, mogger, mog coin, culture coin, culture, crypto, memecoin, meme, fuck you, higher imo, higher, pump, to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_25_17_29_50_d8da93e2c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

