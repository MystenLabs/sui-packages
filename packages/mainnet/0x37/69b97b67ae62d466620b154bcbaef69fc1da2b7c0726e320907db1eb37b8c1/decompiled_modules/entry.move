module 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::assert_is_compatible<T0>(arg0);
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::two_step_role::accept_role<0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::OwnerRole<T0>>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::owner_role_mut<T0>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::assert_is_compatible<T0>(arg0);
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::two_step_role::begin_role_transfer<0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::OwnerRole<T0>>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::owner_role_mut<T0>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::assert_is_compatible<T0>(arg0);
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::update_blocklister<T0>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::assert_is_compatible<T0>(arg0);
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::update_master_minter<T0>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::assert_is_compatible<T0>(arg0);
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::update_metadata_updater<T0>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::assert_is_compatible<T0>(arg0);
        0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::roles::update_pauser<T0>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

