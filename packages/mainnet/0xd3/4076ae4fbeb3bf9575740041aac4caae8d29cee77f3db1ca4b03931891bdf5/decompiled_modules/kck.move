module 0xd34076ae4fbeb3bf9575740041aac4caae8d29cee77f3db1ca4b03931891bdf5::kck {
    struct KCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCK>(arg0, 9, b"KCK", b"Kachako", b"Enhance the economic, social, or cultural development of Kachako", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d29d9bd0-16d1-466a-8dfd-2acee2b9a4e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

