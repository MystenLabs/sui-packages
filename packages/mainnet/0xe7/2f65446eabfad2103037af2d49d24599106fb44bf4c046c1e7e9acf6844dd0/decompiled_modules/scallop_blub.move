module 0xe72f65446eabfad2103037af2d49d24599106fb44bf4c046c1e7e9acf6844dd0::scallop_blub {
    struct SCALLOP_BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_BLUB>(arg0, 2, b"sBLUB", b"sBLUB", b"Scallop interest-bearing token for BLUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gutxmo5scqefen42iu6ysi5unhdsdenwtcqe2z5hxszz3ssdhzsa.arweave.net/NSd2O7IUCFI3mkU9iSO0acchkbaYoE1np7yzncpDPmQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_BLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_BLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

