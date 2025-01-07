module 0xeef76814a70f12afeb2db086f55ba7b269986c019f23ad703ece1952b5bfcbbc::suicraft_regulated_coin {
    struct SUICRAFT_REGULATED_COIN has drop {
        dummy_field: bool,
    }

    public entry fun add_addr_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SUICRAFT_REGULATED_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<SUICRAFT_REGULATED_COIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun freeze_deny_cap(arg0: 0x2::coin::DenyCap<SUICRAFT_REGULATED_COIN>) {
        0x2::transfer::public_freeze_object<0x2::coin::DenyCap<SUICRAFT_REGULATED_COIN>>(arg0);
    }

    public entry fun freeze_meta_data(arg0: 0x2::coin::CoinMetadata<SUICRAFT_REGULATED_COIN>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICRAFT_REGULATED_COIN>>(arg0);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUICRAFT_REGULATED_COIN>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUICRAFT_REGULATED_COIN>>(arg0);
    }

    public entry fun freeze_upgrade_cap(arg0: 0x2::package::UpgradeCap) {
        0x2::transfer::public_freeze_object<0x2::package::UpgradeCap>(arg0);
    }

    fun init(arg0: SUICRAFT_REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SUICRAFT_REGULATED_COIN>(arg0, 0, b"$MYCOIN", b"My Coin", b"Created using https://suicraft.xyz", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICRAFT_REGULATED_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SUICRAFT_REGULATED_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICRAFT_REGULATED_COIN>>(v2, v3);
        0x353285c55887b93db07409c3e27b799596aa574b173ca9cd689a2bb3efbca390::coin_issuance::emit_coin_operation<SUICRAFT_REGULATED_COIN>(b"created", arg1);
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SUICRAFT_REGULATED_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<SUICRAFT_REGULATED_COIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<SUICRAFT_REGULATED_COIN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SUICRAFT_REGULATED_COIN>>(arg0, arg1);
    }

    public entry fun transfer_meta_data(arg0: 0x2::coin::CoinMetadata<SUICRAFT_REGULATED_COIN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICRAFT_REGULATED_COIN>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUICRAFT_REGULATED_COIN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICRAFT_REGULATED_COIN>>(arg0, arg1);
    }

    public entry fun transfer_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: address) {
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

