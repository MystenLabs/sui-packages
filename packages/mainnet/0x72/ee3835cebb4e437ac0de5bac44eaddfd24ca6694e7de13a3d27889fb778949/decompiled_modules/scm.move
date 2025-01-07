module 0x72ee3835cebb4e437ac0de5bac44eaddfd24ca6694e7de13a3d27889fb778949::scm {
    struct SCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCM>(arg0, 6, b"SCM", b"Speeding Cookie Monster", b"Speeding Cookie Monster is a chaotic force of nature, racing through the world with an insatiable hunger for cookies and adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asd678567_4e75c59fc7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

