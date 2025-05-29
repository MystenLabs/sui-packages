module 0xde6c816a698cd83cbab62eb1a0aa1c7ee57ae678318c88aa6df9289374713c17::sfl {
    struct SFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFL>(arg0, 9, b"SfL", b"SUI4LOVERS", b"For thos who love sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/add11b8c609a427e8066c7cd246e9129blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

