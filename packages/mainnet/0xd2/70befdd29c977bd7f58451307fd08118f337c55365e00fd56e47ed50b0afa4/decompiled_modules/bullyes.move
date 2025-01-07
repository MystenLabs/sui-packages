module 0xd270befdd29c977bd7f58451307fd08118f337c55365e00fd56e47ed50b0afa4::bullyes {
    struct BULLYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLYES>(arg0, 6, b"BULLYES", b"YESBULL", x"5945532042554c4c0a464952535420414e44204f4e4c590a53494d504c45202620454646454354495645200a464f4c4c4f5720554e54494c204c4153542042524541544820", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732316594487.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLYES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLYES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

