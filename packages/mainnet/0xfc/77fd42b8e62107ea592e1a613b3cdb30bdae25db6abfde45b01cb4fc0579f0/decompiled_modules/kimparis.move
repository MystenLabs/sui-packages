module 0xfc77fd42b8e62107ea592e1a613b3cdb30bdae25db6abfde45b01cb4fc0579f0::kimparis {
    struct KIMPARIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMPARIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMPARIS>(arg0, 9, b"KIMPARIS", b"Kim Soo Hyun", b"sdfe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/72709b6d8e43a010363ba471d2a9a3f4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIMPARIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMPARIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

