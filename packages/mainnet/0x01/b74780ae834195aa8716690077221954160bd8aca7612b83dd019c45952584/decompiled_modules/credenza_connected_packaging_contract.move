module 0x1b74780ae834195aa8716690077221954160bd8aca7612b83dd019c45952584::credenza_connected_packaging_contract {
    struct ConnectedPackagingState has store, key {
        id: 0x2::object::UID,
        connections: 0x2::table::Table<0x1::string::String, address>,
        nfc_passes: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    public fun claimNFCID(arg0: &mut ConnectedPackagingState, arg1: 0x1::string::String, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.connections, arg1), 0);
        0x2::table::add<0x1::string::String, address>(&mut arg0.connections, arg1, arg2);
    }

    public fun claimNFCPass(arg0: &mut ConnectedPackagingState, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.nfc_passes, arg1)) {
            0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.nfc_passes, arg1);
        };
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.nfc_passes, arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConnectedPackagingState{
            id          : 0x2::object::new(arg0),
            connections : 0x2::table::new<0x1::string::String, address>(arg0),
            nfc_passes  : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
        };
        0x2::transfer::public_transfer<ConnectedPackagingState>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun revokeNFCID(arg0: &mut ConnectedPackagingState, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.connections, arg1)) {
            0x2::table::remove<0x1::string::String, address>(&mut arg0.connections, arg1);
        };
    }

    public fun revokeNFCPass(arg0: &mut ConnectedPackagingState, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.nfc_passes, arg1)) {
            0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.nfc_passes, arg1);
        };
    }

    public fun transferNFCID(arg0: &mut ConnectedPackagingState, arg1: 0x1::string::String, arg2: address, arg3: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.connections, arg1)) {
            0x2::table::remove<0x1::string::String, address>(&mut arg0.connections, arg1);
        };
        0x2::table::add<0x1::string::String, address>(&mut arg0.connections, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

