module 0x214bc10133f33ee29d0c769d3e1b77c1d28177efc4cb035e41b2cd442541c34a::spg {
    struct SPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPG>(arg0, 9, b"SPG", b"Spaghetti", b"Delicious Spaghetti", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82d93e60-d2f7-4044-bbe8-a3e475ff5923.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

