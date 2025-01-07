module 0x3a708b975d8d1a3b495155607c7fbb48e8e774c18bf244cbc09fb140eb33d61c::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 9, b"SUID", b"SuiDuck", b"@Suiduck_On_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836472274200727552/hnsfInjx_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUID>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

