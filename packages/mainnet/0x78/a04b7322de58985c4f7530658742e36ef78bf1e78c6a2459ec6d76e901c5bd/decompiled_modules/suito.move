module 0x78a04b7322de58985c4f7530658742e36ef78bf1e78c6a2459ec6d76e901c5bd::suito {
    struct SUITO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITO>, arg1: 0x2::coin::Coin<SUITO>) {
        0x2::coin::burn<SUITO>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITO>>(0x2::coin::mint<SUITO>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SUITO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<SUITO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SUITO>(arg0, 6, b"SXTOKEN", b"SXTOKEN CON CAC", b"In the shadows, a community arose, a new vibe, a mischievous vibe. It's all about the community and art. Together, we're building a playful realm where creativity and fun collide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.dexscreener.com/cms/images/8-uQSKncSP8vx67o?width=56&height=56&fit=crop&quality=95&format=auto"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SUITO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SUITO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<SUITO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

