module 0x2314b6642838ebe03a79449d247dc06cd3f4c2e401a163229727156b0e24749b::babywewe {
    struct BABYWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWEWE>(arg0, 9, b"BABYWEWE", b"Babywewe", b"Baby Wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5eadf35d-1cf9-49da-944f-12bf659ae66c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

