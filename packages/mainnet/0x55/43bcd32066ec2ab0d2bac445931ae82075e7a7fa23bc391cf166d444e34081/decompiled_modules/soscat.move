module 0x5543bcd32066ec2ab0d2bac445931ae82075e7a7fa23bc391cf166d444e34081::soscat {
    struct SOSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOSCAT>(arg0, 6, b"SOSCAT", b"SOSCAT on SUI", b"$SOSCAT the lucky cat is here to SOS our wallets!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lyh_Q_Yt_OY_400x400_6f6ab19160.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

