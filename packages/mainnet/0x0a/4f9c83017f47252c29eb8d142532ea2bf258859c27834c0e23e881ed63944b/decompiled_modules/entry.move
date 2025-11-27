module 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::assert_is_compatible<T0>(arg0);
        0xc603569af67780546547523632e88c0840c9b09b12bc4c25f844a419b9645624::two_step_role::accept_role<0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::OwnerRole<T0>>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::owner_role_mut<T0>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::assert_is_compatible<T0>(arg0);
        0xc603569af67780546547523632e88c0840c9b09b12bc4c25f844a419b9645624::two_step_role::begin_role_transfer<0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::OwnerRole<T0>>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::owner_role_mut<T0>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::assert_is_compatible<T0>(arg0);
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::update_blocklister<T0>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::assert_is_compatible<T0>(arg0);
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::update_master_minter<T0>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::assert_is_compatible<T0>(arg0);
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::update_metadata_updater<T0>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::assert_is_compatible<T0>(arg0);
        0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::roles::update_pauser<T0>(0xa4f9c83017f47252c29eb8d142532ea2bf258859c27834c0e23e881ed63944b::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

