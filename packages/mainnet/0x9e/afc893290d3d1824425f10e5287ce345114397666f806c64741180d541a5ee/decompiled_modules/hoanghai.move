module 0x9eafc893290d3d1824425f10e5287ce345114397666f806c64741180d541a5ee::hoanghai {
    struct HOANGHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOANGHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOANGHAI>(arg0, 9, b"HOANGHAI", b"Hoanghai20", b"Hoanghai20 201290", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecfcc150-d5a8-4a5c-9def-e9803624e16d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOANGHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOANGHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

