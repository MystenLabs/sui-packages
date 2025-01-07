module 0xf4a348cbc032ce5f2ba9968106cd1b24169298317314e16b8055e24ef01af002::br {
    struct BR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BR>(arg0, 9, b"BR", b"Bro", b"I'm bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cd09695-2910-477b-a504-626688c27e39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BR>>(v1);
    }

    // decompiled from Move bytecode v6
}

