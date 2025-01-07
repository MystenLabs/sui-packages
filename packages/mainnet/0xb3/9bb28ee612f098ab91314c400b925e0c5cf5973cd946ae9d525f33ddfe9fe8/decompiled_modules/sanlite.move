module 0xb39bb28ee612f098ab91314c400b925e0c5cf5973cd946ae9d525f33ddfe9fe8::sanlite {
    struct SANLITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANLITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANLITE>(arg0, 6, b"SANLITE", b"Santa's Little Helper", x"53616e74612773206c6974746c652068656c706572206973206865726520746f206765742061646f70746564206f6e205355492c206c65742074686174207261636520646f6720626520726163696e670a536f6f6e2077652077696c6c2063656c6562726174652074686973204368726973746d61730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_143529_291_59f441a52f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANLITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANLITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

