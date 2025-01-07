module 0x4c6ccff112168cce7b0a060ab93af50faac3068adf54e0e92603ca3090cf9c9a::suisigma {
    struct SUISIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISIGMA>(arg0, 6, b"SUISIGMA", b"SuiSigma", b"A meme coin dedicated to thinking differently about the world around you, doing what is best for yourself and those around you, and having fun in the process while thinking critically.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_a50af10d29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISIGMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISIGMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

