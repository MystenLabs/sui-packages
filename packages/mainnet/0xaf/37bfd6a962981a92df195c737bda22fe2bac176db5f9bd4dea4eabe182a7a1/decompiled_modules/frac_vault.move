module 0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::frac_vault {
    struct VaultWrapper has store, key {
        id: 0x2::object::UID,
        vault: 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::frac_coin::FRAC_COIN, 0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT>,
    }

    public fun deposit_into_storage(arg0: &mut VaultWrapper, arg1: 0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::frac_coin::FRAC_COIN> {
        let v0 = 0x1::vector::empty<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT>();
        0x1::vector::push_back<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT>(&mut v0, arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::interface::deposit_into_kiosk_storage_get_coin<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::frac_coin::FRAC_COIN, 0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT>(&mut arg0.vault, arg2, v0, arg3, arg4)
    }

    public fun initialize_vault(arg0: 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::CreateVaultCap<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::frac_coin::FRAC_COIN>, arg1: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::Config, arg2: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper::SharedWrapper<0x2::package::Publisher>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::interface::create_vault<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::frac_coin::FRAC_COIN, 0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT>(arg0, arg1, arg2, arg3, 1000000000, false, true, true, b"Sui Generis HC", b"https://bafkreiclbtpl35v5lzpmpucdh3tqg5m262a64yjsdaavoasis57gjhdd6u.ipfs.nftstorage.link/", b"https://bafkreiclbtpl35v5lzpmpucdh3tqg5m262a64yjsdaavoasis57gjhdd6u.ipfs.nftstorage.link/", b"https://suigeneris.auction/", b" Sui Generis House Collection Fractionalized coins", arg4);
        let v2 = VaultWrapper{
            id    : 0x2::object::new(arg4),
            vault : v0,
        };
        0x2::transfer::public_share_object<VaultWrapper>(v2);
        0x2::transfer::public_transfer<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::frac_coin::FRAC_COIN, 0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::collection::HouseCollectionNFT>>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

