module 0x7379f41c4c893d2032495caf70ac19bb5975dbdf6cdbee2d97b7331d75bca8ad::prf {
    struct PRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRF>(arg0, 9, b"PRF", b"perfecto", b"The flawless cryptocurrency that's delivering impeccable profits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58bcab89-17fc-4d76-9c65-bad481136172.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

