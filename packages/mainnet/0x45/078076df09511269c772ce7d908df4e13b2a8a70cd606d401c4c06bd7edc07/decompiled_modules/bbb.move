module 0x45078076df09511269c772ce7d908df4e13b2a8a70cd606d401c4c06bd7edc07::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"BBB", b"Blop", b"The next AAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe0d0b97-8a70-4441-941a-291df92b21ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

