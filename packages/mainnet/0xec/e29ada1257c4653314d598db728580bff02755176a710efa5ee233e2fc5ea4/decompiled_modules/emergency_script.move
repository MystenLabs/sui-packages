module 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency_script {
    public entry fun pause(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::EmergencyAdminCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::pause(arg0, 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_emergency_status(arg1));
    }

    public entry fun resume(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::EmergencyAdminCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::emergency::resume(arg0, 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut_emergency_status(arg1));
    }

    // decompiled from Move bytecode v6
}

