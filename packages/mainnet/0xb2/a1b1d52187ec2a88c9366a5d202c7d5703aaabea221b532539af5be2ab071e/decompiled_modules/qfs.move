module 0xb2a1b1d52187ec2a88c9366a5d202c7d5703aaabea221b532539af5be2ab071e::qfs {
    struct QFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QFS>(arg0, 9, b"QFS", b"Qfs17", b"Quantum Financial System", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff026da0-40ee-41f0-b695-e9302515209a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

