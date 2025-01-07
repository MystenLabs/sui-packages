module 0x70a2e5e961cb7206e075829156d780f219cf01f8e06d1370dee8f9a560ecad0f::szu {
    struct SZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZU>(arg0, 6, b"SZU", b"SUI TZU", b"THIS IS ONE AND ONLY SUI TZU IN MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002548778_1e74721473.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

