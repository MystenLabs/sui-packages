module 0x476e6f205f1b6840bb7cfbf7d13337d3fc3993e22b12f98c4b6999c413250342::knight {
    struct KNIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNIGHT>(arg0, 9, b"KNIGHT", b"Iluminacja", b"you cannot become a knight of the order before you are born, deep in your soul and heart enter the world of illumination and follow the path of the ancient order", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/352db3f8-b912-49dd-b062-92747d7cbd14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

