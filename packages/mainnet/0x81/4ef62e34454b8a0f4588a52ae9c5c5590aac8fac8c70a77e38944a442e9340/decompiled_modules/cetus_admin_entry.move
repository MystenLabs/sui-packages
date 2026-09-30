module 0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_admin_entry {
    public fun migrate(arg0: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_entry::migration_witness();
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::migrate_ext_version<0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_entry::CetusLegAuth>(arg0, arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_CETUS(), 0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_entry::package_version(), &v0, arg2);
    }

    public fun register_cetus_hasui_leg_auth<T0>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_entry::authorize(arg0);
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::register_protocol_leg_auth<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_entry::CetusLegAuth>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_CETUS(), arg2);
    }

    public fun register_cetus_leg_auth<T0>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<0x2::sui::SUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_entry::authorize(arg0);
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, 0x814ef62e34454b8a0f4588a52ae9c5c5590aac8fac8c70a77e38944a442e9340::cetus_entry::CetusLegAuth>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_CETUS(), arg2);
    }

    // decompiled from Move bytecode v7
}

