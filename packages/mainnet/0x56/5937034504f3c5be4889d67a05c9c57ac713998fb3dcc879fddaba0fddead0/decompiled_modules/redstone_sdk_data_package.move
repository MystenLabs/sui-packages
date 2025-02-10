module 0x565937034504f3c5be4889d67a05c9c57ac713998fb3dcc879fddaba0fddead0::redstone_sdk_data_package {
    struct DataPackage has copy, drop {
        signer_address: vector<u8>,
        timestamp: u64,
        data_points: vector<DataPoint>,
    }

    struct DataPoint has copy, drop {
        feed_id: vector<u8>,
        value: vector<u8>,
    }

    public fun data_points(arg0: &DataPackage) : &vector<DataPoint> {
        &arg0.data_points
    }

    public fun feed_id(arg0: &DataPoint) : &vector<u8> {
        &arg0.feed_id
    }

    public fun new_data_package(arg0: vector<u8>, arg1: u64, arg2: vector<DataPoint>) : DataPackage {
        DataPackage{
            signer_address : arg0,
            timestamp      : arg1,
            data_points    : arg2,
        }
    }

    public fun new_data_point(arg0: vector<u8>, arg1: vector<u8>) : DataPoint {
        DataPoint{
            feed_id : arg0,
            value   : arg1,
        }
    }

    public fun signer_address(arg0: &DataPackage) : &vector<u8> {
        &arg0.signer_address
    }

    public fun timestamp(arg0: &DataPackage) : u64 {
        arg0.timestamp
    }

    public fun value(arg0: &DataPoint) : &vector<u8> {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

