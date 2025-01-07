module 0xd8deede796553f226093498cf5cd5309e0965cc175265b7bdafc96bf6be35287::bp {
    struct BP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BP>(arg0, 9, b"BP", b"python", b"This token is dedicated to the beautiful Ball pythons! (Python regius). ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eac1417e-fae4-4f75-b7bb-2cdf01385247.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BP>>(v1);
    }

    // decompiled from Move bytecode v6
}

