module 0xa5936c1bac17bc442af3e127259ade7d5820a41934db2182b6a468bdf7524eca::prh {
    struct PRH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRH>(arg0, 9, b"PRH", b"Tulumbu", b"Hardship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/848a4178-fc7c-46f8-a96a-4c6326330cab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRH>>(v1);
    }

    // decompiled from Move bytecode v6
}

