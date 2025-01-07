module 0x61910b3ce8aa48067444a8c0c18d9c6ab730e7658fc4c18235048403c78bcc7a::wsm {
    struct WSM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WSM>, arg1: 0x2::coin::Coin<WSM>) {
        0x2::coin::burn<WSM>(arg0, arg1);
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<WSM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<WSM>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<WSM>(arg0, 9, b"WSM", b"WSM Token", b"WSM Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://walletsmart.co/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WSM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun khoa() {
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WSM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WSM>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<WSM>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WSM>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<WSM>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSM>>(arg0, arg1);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<WSM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<WSM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

