module 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project_entries {
    public entry fun buy<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::buy<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun change_admin(arg0: 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::AdminCap, arg1: address) {
        0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::change_admin(arg0, arg1);
    }

    public entry fun claim_refund<T0, T1>(arg0: &mut 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::Project<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::claim_refund<T0, T1>(arg0, arg1);
    }

    public entry fun claim_token<T0, T1>(arg0: &mut 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::claim_token<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun create_project<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::create_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun distribute_raised_fund<T0, T1>(arg0: &mut 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::Project<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::project::distribute_raised_fund<T0, T1>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

