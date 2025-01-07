module 0xfa39ed5d4a7ef8443413266a0e6852bcff43240111bc9e0f214eacbf97ded5a2::cbn {
    struct CBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBN>(arg0, 9, b"CBN", b"Canabis", b"Promoting the use of canabis and its advantage within the society", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db3d0b67-0fd0-4fda-82f9-03b4fbb50172.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

