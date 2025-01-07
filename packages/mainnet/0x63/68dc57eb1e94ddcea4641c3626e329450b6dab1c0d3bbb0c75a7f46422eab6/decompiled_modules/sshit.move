module 0x6368dc57eb1e94ddcea4641c3626e329450b6dab1c0d3bbb0c75a7f46422eab6::sshit {
    struct SSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIT>(arg0, 6, b"sSHIT", b"SUISHIT", b"Sh1t Sh!t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dawdwa_27f6b7be35.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

