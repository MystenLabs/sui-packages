module 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::seal_policy {
    public fun seal_approve<T0>(arg0: vector<u8>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0 == x"00", 13906834290307563522);
        assert!(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::verify_signature<T0, vector<u8>>(arg1, 1, arg2, arg3, &arg4), 13906834303192596484);
    }

    // decompiled from Move bytecode v7
}

