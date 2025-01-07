module 0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::frac_vault {
    public fun deposit_into_storage(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::frac_coin::FRAC_COIN, 0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::collection::HouseCollectionNFT>, arg1: 0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::collection::HouseCollectionNFT, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::collection::HouseCollectionNFT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::frac_coin::FRAC_COIN> {
        let v0 = 0x1::vector::empty<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::collection::HouseCollectionNFT>();
        0x1::vector::push_back<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::collection::HouseCollectionNFT>(&mut v0, arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::interface::deposit_into_kiosk_storage_get_coin<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::frac_coin::FRAC_COIN, 0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::collection::HouseCollectionNFT>(arg0, arg2, v0, arg3, arg4)
    }

    public fun initialize_vault(arg0: 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::CreateVaultCap<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::frac_coin::FRAC_COIN>, arg1: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::Config, arg2: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper::SharedWrapper<0x2::package::Publisher>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::interface::publish_vault<0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::frac_coin::FRAC_COIN, 0xfe325932fcc32fbe696fe5062231dc4f1465b961d71ce9b62eb8bf5ff802798::collection::HouseCollectionNFT>(arg0, arg1, arg2, arg3, 1000000000, true, true, true, b"Sui Generis HC", b"https://bafkreiclbtpl35v5lzpmpucdh3tqg5m262a64yjsdaavoasis57gjhdd6u.ipfs.nftstorage.link/", b"https://bafkreiclbtpl35v5lzpmpucdh3tqg5m262a64yjsdaavoasis57gjhdd6u.ipfs.nftstorage.link/", b"https://suigeneris.auction/", b" Sui Generis House Collection Fractionalized coins", arg4);
    }

    // decompiled from Move bytecode v6
}

