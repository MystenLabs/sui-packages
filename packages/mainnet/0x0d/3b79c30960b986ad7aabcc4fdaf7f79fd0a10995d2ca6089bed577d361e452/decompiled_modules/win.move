module 0xd3b79c30960b986ad7aabcc4fdaf7f79fd0a10995d2ca6089bed577d361e452::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 9, b"WIN", b"WINNER", b"Win this shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://as1.ftcdn.net/v2/jpg/01/16/35/40/1000_F_116354024_F2XTUWBnt3evzvXM6mdJPN4yTpg4J1rO.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

