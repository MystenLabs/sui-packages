module 0xbfcfb1f1efb354d02ccf6bc50741e95bf8c2e5aa14b3bf6b3b7113fa4d88b352::sshomaru {
    struct SSHOMARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHOMARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHOMARU>(arg0, 6, b"SSHOMARU", b"Suisshomaru", x"5375697373686f6d6172753a205265616368696e67206e657720686569676874732c2068656164696e6720746f20746865206d6f6f6e206f6e2074686520537569206e6574776f726b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/407aae5bfa13c2504f3eaa1ca5ce0313_98c50d7e9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHOMARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHOMARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

