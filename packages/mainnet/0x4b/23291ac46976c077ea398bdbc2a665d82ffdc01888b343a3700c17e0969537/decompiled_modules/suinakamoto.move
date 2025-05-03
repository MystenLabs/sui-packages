module 0x4b23291ac46976c077ea398bdbc2a665d82ffdc01888b343a3700c17e0969537::suinakamoto {
    struct SUINAKAMOTO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINAKAMOTO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x171e71f00cc302ae1732a79ca6d2ca686c243c1dd304c4d3279cc6b512050aa, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINAKAMOTO>>(0x2::coin::mint<SUINAKAMOTO>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUINAKAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAKAMOTO>(arg0, 9, b"KISHUINU", b"Kishu Inu", b"Kishu Inu on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/V6rsnVjC/KISHU-INU.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAKAMOTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAKAMOTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

