module 0x18c4bd416d8bee1cc85de70a2aae60aa4fd877851a967eb750c50fc553c05576::aaapug {
    struct AAAPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPUG>(arg0, 6, b"AAAPUG", b"Pug September", b"4444", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GWD_Vm_E_Db_QAA_2iyd_75ada365d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

