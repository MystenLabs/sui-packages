module 0x1bcfe073b8c5fe174e1656ac669bde199be0cef86125b859082db8ff78772686::wecat {
    struct WECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WECAT>(arg0, 9, b"WECAT", b"MAGA", b"Maga meme is inspired by the spirit of cats funny and adventure. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42455f70-1ab1-46c3-92e4-3a600a786096.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

