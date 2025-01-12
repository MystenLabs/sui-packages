module 0x8be8a298d83faa57435d1e0785f31d904ba9f360ecb7b55c59259800c528a093::jhi {
    struct JHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHI>(arg0, 9, b"JHI", b"jhi", b"jhi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxj5gx37b3fothpvnd74uv5ji74j7lwjrczetl25ldkkktxr6tgy?X-Algorithm=PINATA1&X-Date=1736720510&X-Expires=315360000&X-Method=GET&X-Signature=b7c64290baf3ca4b11da4af48680996fcee0e130231e7be95854a54c0b63eb9a"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

