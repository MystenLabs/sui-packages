module 0xeb690ec85b6eabef3522c47ef3c7ca4c59de7e309d41a492c66ed73f64d3a10e::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"GLOO", b"Sui Gloo", x"474c4f4f204953204c494b4520412054494e592c20574f42424c5920534b590a44524f502057495448204c454753212042494720455945532c0a535455424259204c4954544c4520464545542c20414e4420410a434c554d535920434841524d2054484154204d414b45530a48455220495252455349535449424c5920435554452e20410a535155495348592042554e444c45204f462041444f5241424c450a41574b574152444e45535321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000424_c36d32e9ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

