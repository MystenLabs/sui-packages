module 0x43d23c5a7c53c1e058c65e239ea39fbb776f66601fc29a772134f83a58ad9fc5::lockedin {
    struct LOCKEDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKEDIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKEDIN>(arg0, 6, b"LOCKEDIN", b"LockedIn", b"Are you ready to get $LockedIn! It's bull season and the only way is up! Join the journey now! [ Telegram : https://t.me/getlockedinsui ] [ Twitter : https://x.com/getlockedinsui ] [ Website : https://lockedin.sbs ]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_0711a740d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKEDIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCKEDIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

